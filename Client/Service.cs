using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinet
{

    public class Service
    {
        public int[,] graph { get; set; }
        int s;

        public void genGraph(int s)
        {
            this.s = s;
            var rand = new Random();

            graph = new int[s, s];

            for (int i = 0; i < s; i++)
            {
                for (int j = 0; j < s; j++)
                {
                    graph[i, j] = rand.Next(1, 50);
                }
            }
        }

        public void printGraph()
        {
            for (int i = 0; i < s; i++)
            {
                for (int j = 0; j < s; j++)
                {
                    Console.Write(graph[i, j] + " ");
                }
                Console.WriteLine();
            }
        }

        public void division()
        {
            int mn = graph[0, 0];
            for (int i = 0; i < s; i++)
            {
                for (int j = 0; j < s; j++)
                {
                    mn = Math.Min(mn, graph[i, j]);
                }
            }

            for (int i = 0; i < s; i++)
            {
                for (int j = 0; j < s; j++)
                {
                    graph[i, j] /= mn;
                }
            }
        }
    }
}
