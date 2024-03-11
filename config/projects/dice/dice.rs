use std::io;
use std::thread;
use std::sync::mpsc;

fn inputs() -> (u32,u32,u32,u32,u32)
{
  let mut input_text1 = String::new();
  println!("How many faces does the dices have:");
  io::stdin()
      .read_line(&mut input_text1)
      .unwrap();
  let trimmed = input_text1.trim();
  let dc = trimmed.parse::<u32>().unwrap();

  let mut input_text2 = String::new();
  println!("Enter first person's dice count:");
  io::stdin()
      .read_line(&mut input_text2)
      .unwrap();
  let trimmed = input_text2.trim();
  let p1d = trimmed.parse::<u32>().unwrap()-1;

  println!("Enter first person's bonus:");
  let mut input_text3 = String::new();
  io::stdin()
      .read_line(&mut input_text3)
      .unwrap();
  let trimmed = input_text3.trim();
  let p1b = trimmed.parse::<u32>().unwrap();

  let mut input_text4 = String::new();
  println!("Enter second person's dice count:");
  io::stdin()
      .read_line(&mut input_text4)
      .unwrap();
  let trimmed = input_text4.trim();
  let p2d = trimmed.parse::<u32>().unwrap()-1;

  let mut input_text5 = String::new();
  println!("Enter second person's bonus:");
  io::stdin()
      .read_line(&mut input_text5)
      .unwrap();
  let trimmed = input_text5.trim();
  let p2b = trimmed.parse::<u32>().unwrap();
  
  return (dc, p1d, p1b, p2d, p2b)
}  

fn rolls<'a>(
  faces: u32,
  count: u32,
  frnt: &'a mut Vec<u32>,
  lst: &'a mut Vec<Vec<u32>>, 
  counti: u32
  ) -> &'a mut Vec<Vec<u32>>
{
  for i in 1..faces+1 {
    if count == 0 {
      frnt.push(i);
      lst.push(frnt.clone());
    }
    else {
      frnt.push(i);
      let _ = rolls(faces, count-1,frnt,lst,counti);
    }
    frnt.pop();
  }
  if count==counti{
    return lst
  }
  else {
    return lst 
  }
}

fn sums(lst: Vec<Vec<u32>>, bns: u32) -> Vec<u32>
{
  let mut res: Vec<u32> = vec![];
  for i in lst {
    let mut x = 0;
    for j in i {
      x = x + j
    }
    x = x + bns;
    res.push(x);
  }
  return res
}

fn compare(x: Vec<u32>, y: Vec<u32>)  -> (u128,u128,u128)
{
  let mut w:u128=0;
  let mut d:u128=0;
  let mut l:u128=0;
  for i in &x {
    for j in &y { 
      if i > j {
        w=w+1;
      }
      else if i < j {
        l=l+1;
      }
      else {
        d=d+1;
      }
    }
  }
  return (w,d,l)
}

fn main() {

  let (dc, p1d, p1b, p2d, p2b) = inputs();
  
  
  let mut frn1: Vec<u32> = vec![];
  let mut ls1: Vec<Vec<u32>> = vec![];
  let frn2: &mut Vec<u32> = &mut vec![];
  let ls2: &mut Vec<Vec<u32>> = &mut vec![];

  let (tx, rx) = mpsc::channel();
  
  let first = thread::spawn(move || {
    println!("calculating possible rolls for first person....");
    let x = rolls(dc, p1d, &mut frn1, &mut ls1, p1d);
    println!("calculating sum of possible rolls for first person....");
    let sumx: Vec<u32> = sums(x.to_vec(),p1b);
    tx.send(sumx).unwrap();
  });

  println!("calculating possible rolls for second person....");
  let y = rolls(dc, p2d, frn2, ls2, p2d);
  println!("calculating sum of possible rolls for second person....");
  let sumy: Vec<u32> = sums(y.to_vec(),p2b);

  let sumx = rx.recv().unwrap();
  first.join().unwrap();
  
  println!("comparing sums....");
  let (w,d,l) = compare(sumx,sumy);
  println!("wins:{}, draws:{}, loses:{}", w,d,l);
  
}
