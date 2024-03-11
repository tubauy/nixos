/*
This program calculates the possible results of a game where players have a variable number of dices
and bonuses. 
For exemple player 1 could have 2 dices and a 3 point bonus and player 2 could have 3 dices but no bonus.
(would result in : wins:3888 draws:780 loses:3108)
Know that this is only for testing and exercice so i have reinvented the wheel knowing that i could do it
the easier way. Even so any and all recomendations on the coding style, best practices, the optimisation
of the algorithm, etc... are welcome.
*/
using  System;
using System.Runtime.InteropServices;

namespace Dice;

class DiceGame 
{
    //
    //for testing only no actual use in the complete program
    //i have told you i reinvented the wheel :)
    //private static void PrintList(List<int> lst) 
    //{
    //    foreach (var j in lst)
    //    {
    //        Console.WriteLine(j);
    //    }
    //}
    //
    //private static void PrintNestedList(List<List<int>> lst)
    //{
    //    foreach (var i in lst)
    //    {
    //        PrintList(i);
    //    }
    //}

    private static List<List<int>> RollsInternal(int faces, int count, List<int> frnt, List<List<int>> lst) 
    //Generate possible rolls
    {
        //İdea based on depth first search
        foreach (var i in Enumerable.Range(1, faces))
        {
            if (count == 0)
            {
                frnt.Add(i);
                lst.Add(frnt.ToList());
            }
            else 
            {
                frnt.Add(i);
                RollsInternal(faces, count-1,frnt,lst);
            }
            frnt.RemoveAt(frnt.Count - 1);
        }
        return lst;
    }
     
    private static List<List<int>> Rolls(int faces, int count) 
    //wrap the actual function so that count and empty lists don't need to be repeated
    {
        return RollsInternal(faces,count-1,new List<int> {},new List<List<int>> {});
    }
    
    private static List<int> Sum(List<List<int>> lst, int bonus) 
    // get the sum of all possible rolls generated
    {
        var result = new List<int>();
        foreach (List<int> i in lst)
        {
            int x = 0;
            foreach (int j in i)
            {
                x += j;
            }
            result.Add(x+bonus);
        }
        return result;
    }

    private static (int,int,int) Compare(List<int> lst1, List<int> lst2) 
    //compare sums generated
    {
        var (w,d,l) = (0, 0, 0);
        foreach (int i in lst1)
        {
            foreach(int j in lst2)
            {
                if (i>j) 
                {
                    w++;
                }
                else if (i<j)
                {
                    l++;
                }
                else 
                {
                    d++;
                }
            }
        }
        return (w,d,l);
    }

    private static (double, double, double) ThreeToPercentages(double x, double y, double z)
    {
        double total = x+y+z;
        var resultx = ((x/total)*100);
        var resulty = (y/total)*100;
        var resultz = (z/total)*100;
        return (resultx, resulty, resultz);
    }

    public static (int,int,int) Calculate (int faces, int firstDiceCount, int firstBonus, int secondDiceCount, int secondBonus)
    {
        return Compare(Sum(Rolls(faces,firstDiceCount),firstBonus), Sum(Rolls(faces,secondDiceCount),secondBonus));
    }

    public static (double, double, double) CalculatePercentage (int faces, int firstDiceCount, int firstBonus, int secondDiceCount, int secondBonus)
    {

        var (wins,draws,loses) = Calculate(faces,firstDiceCount,firstBonus, secondDiceCount,secondBonus);
        return ThreeToPercentages(wins, draws, loses);
    }

    public static (int,int,int) CalculatePercentageRounded (int faces, int firstDiceCount, int firstBonus, int secondDiceCount, int secondBonus) 
    {
        var (winp, drawp, losep) = CalculatePercentage(faces,firstDiceCount,firstBonus, secondDiceCount,secondBonus);
        return ((int) winp, (int) drawp, (int) losep);
    }

    public static void Main()
    {
        var (wins,draws,loses) = Calculate(6,2,4,3,0);
        var (winp, drawp, losep) = CalculatePercentageRounded(6,2,4,3,0);
        Console.WriteLine($"wins:{wins} draws:{draws} loses:{loses}");
        Console.WriteLine($"wins:{(int) winp}% draws:{(int) drawp}% loses:{(int) losep}%");
    }
}