using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using System.ComponentModel;
using System.Drawing;

namespace Sppr.Controllers
{

    [ApiController]
    [Route("/")]
    public class ServiceController : ControllerBase
    {
        
        [HttpGet("/getMatrix/{size}")]
        public int[][] GenMatrix(int size)
        {
            var rand = new Random();
            int[][] ints = new int[size][];
            for (int i = 0; i < size; i++)
            {
                ints[i] = new int[size];
                for (int j = 0; j < size; j++)
                {
                    ints[i][j] = rand.Next(1, 100);
                }
            }
            return ints;
        }

        [HttpPost("/divide")]
        public int[][] DivideByMinimum([FromBody] int[][] graph)
        {
            int min = int.MaxValue;
            for (int i = 0;i < graph.Length;i++)
            {
                for (int j = 0;j < graph[i].Length; j++)
                {
                    min = Math.Min(min, graph[i][j]);
                }
            }
            for (int i = 0; i < graph.Length; i++)
            {
                for (int j = 0; j < graph[i].Length; j++)
                {
                    graph[i][j] /= min; 
                }
            }
            return graph;
        }


        [HttpGet]
        public string hello()
        {
            return "Hello Wordl!";
        }
    }
}
