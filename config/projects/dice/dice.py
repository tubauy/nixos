print("The results are printed as [wins, draws, loses] for the first person")
faces = int(input("how many faces does the dices have?:"))
p1r = int(input("Enter first person's dice count:"))
p1b = int(input("Enter first person's bonus:"))
p2r = int(input("Enter second person's dice count:"))
p2b = int(input("Enter second person's bonus:"))

dice = range(1, faces + 1)


#all possible rolls
def rolls(count, frontier, lst, counti):
  for i in dice:
    if count == 0:
      frontier.append(i)
      f = list(frontier)
      lst.append(f)
    else:
      frontier.append(i)
      rolls(count - 1, frontier, lst, 1)
    frontier.pop(-1)
  return lst


#sum but implemented by hand because i went insane
def sums(lst):
  res = 0
  for i in lst:
    res += i
  return res


#sum but for 2 dimensional lists
def sumall(lst, bonus):
  res = []
  for i in lst:
    res.append(sums(i) + bonus)
  return res


#calculates the score
def score(lst1, lst2):
  wins = 0
  draws = 0
  loses = 0
  for i in lst1:
    for j in lst2:
      if i > j:
        wins += 1
      elif i == j:
        draws += 1
      else:
        loses += 1
  res = [wins, draws, loses]
  return res


#getting the results
x = sumall(rolls(p1r - 1, [], [], p1r - 1), p1b)
y = sumall(rolls(p2r - 1, [], [], p2r - 1), p2b)
res = score(x, y)


def rates(lst):
  sum = lst[0] + lst[1] + lst[2]
  wr = lst[0] / sum * 100
  dr = lst[1] / sum * 100
  lr = lst[2] / sum * 100
  return [wr, dr, lr]


print(res)
print(rates(res))
