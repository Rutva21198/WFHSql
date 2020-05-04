using System;
using System.Collections.Generic;

namespace GenericStack
{
    class Program
    {
        static void Main(string[] args)
        {
            Stack<int> first = new Stack<int>();
            first.Push(50);
            first.Push(45);
            first.Push(11);
            first.Push(7);

            Stack<int> second = new Stack<int>();
            second.Push(67);
            second.Push(65);
            second.Push(32);
            second.Push(12);

            ProcessInOrder(first, second);

            Console.WriteLine(
                "Press any key to continue...");
            Console.ReadKey();
        }

        static void ProcessInOrder(Stack<int> first,
            Stack<int> second)
        {
            while (first.Count > 0 || second.Count > 0)
            {
                if (first.Count == 0)
                {
                    Console.WriteLine(second.Pop());
                    continue;
                }

                if (second.Count == 0)
                {
                    Console.WriteLine(first.Pop());
                    continue;
                }

                if (first.Peek() >= second.Peek())
                {
                    Console.WriteLine(
                        second.Pop());
                }
                else
                {
                    Console.WriteLine(first.Pop());
                }
            }
        }
    }
}
