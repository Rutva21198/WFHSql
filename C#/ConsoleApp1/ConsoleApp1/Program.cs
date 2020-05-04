using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace ConsoleApp1
{
    class Student
    {
        private int id;
        private string n;
    }
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            int[] no = { 12, 45, 67, 78, 78 };
            var nm = no.Where(k => k > 45).First();
            Console.WriteLine(nm);
        }
    }
}
