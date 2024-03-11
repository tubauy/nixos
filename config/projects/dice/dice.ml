open Printf

(*generate possible roll combinations*)
let rec rolls current goal = 
  (*calculate the ext roll based on the current one*)
  let addOne c g = if (List.for_all2 (==) c g) then g else 
    (*helper for tail recursion*)
    let rec addOneHelper cr gl i = 
      if List.nth cr i == List.nth gl i  
      then addOneHelper (List.mapi (fun ind x -> if (ind == i) then 1 else x) cr) gl (i-1)
      else List.mapi (fun ind x -> if (ind == i) then x+1 else x) cr
    in
    addOneHelper (c) (g) ((List.length c)-1)
  in
  if (addOne current goal) == goal
  then [goal]
  else current :: (rolls (addOne current goal) goal)

(*facilitate the use of rolls function by initiating the list from integers 
   instead of giving them to the function every time*)
let diceRoller n = 
  let intList a b = List.init a (fun _ -> b) in
  rolls (intList n 1) (intList n 6)

let player n b = List.map (fun x -> List.fold_left (+) b x) (diceRoller n)

(*compare results of rolls *)
let compareEach a b = 
  let compareInt lst x = List.map (compare x) lst in
  List.map (compareInt b) a

(*count the results of rolls*)
(*if trying to only deduce the winner one could simlpy 
   add the results since they are either -1 or 0 or 1*)
let rec count lst wacc dacc lacc = 
  (*helper for tail recursion*)
  let rec counth lst wacc dacc lacc = 
    match lst with
    | [] -> [wacc; dacc; lacc]
    | h::t -> 
      if h == 1 then (counth t (wacc+1) dacc lacc) 
      else if h == 0 then (counth t wacc (dacc+1) lacc) 
      else (counth t wacc dacc (lacc+1)) 
  in
  match lst with 
  | [] -> [wacc; dacc; lacc]
  | h::t -> count t (wacc+(List.nth (counth h 0 0 0) 0)) 
                    (dacc+(List.nth (counth h 0 0 0) 1)) 
                    (lacc+(List.nth (counth h 0 0 0) 2))

(*bind the result to a variable to simplify the final print function*)
let result = count (compareEach (player 3 0) (player 2 3)) 0 0 0
 
let () = List.iter (printf "%d \n") result
