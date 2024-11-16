using System.Text.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Clinet
{

    public class Service
    {
        public int[][] graph { get; set; }
        int s;

        private static HttpClient sharedClient = new()
        {
            BaseAddress = new Uri("http://host.docker.internal:5050"),
            Timeout = TimeSpan.FromSeconds(30)
        };

        async public Task genGraph(int s)
        {
            using HttpResponseMessage response = await sharedClient.GetAsync($"/getMatrix/{s}");
            string content = await response.Content.ReadAsStringAsync();
            graph = System.Text.Json.JsonSerializer.Deserialize<int[][]>(content);
            this.s = s;
        }

        public void printGraph()
        {
            for (int i = 0; i < s; i++)
            {
                for (int j = 0; j < s; j++)
                {
                    Console.Write(graph[i][j] + " ");
                }
                Console.WriteLine();
            }
        }

        async public Task division()
        {
            var json = JsonConvert.SerializeObject(graph);
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            using HttpResponseMessage response = await sharedClient.PostAsync($"/divide", data);
            string content = await response.Content.ReadAsStringAsync();
            graph = System.Text.Json.JsonSerializer.Deserialize<int[][]>(content);
        }
    }
}
