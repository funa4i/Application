using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinet
{
    public class Client
    {

        private Service service;

        public Client() { 
            service = new Service();
        }


        public void sartIt()
        {
            Console.WriteLine("Ваша первая матрица");
            string ins;
            do
            {
                Console.WriteLine(
@"
1. Сгенерировать матрицу размером 5
2. Разделить на минимум в матрице 
3. Показать матрицу");

                ins = Console.ReadLine();
                switch (ins)
                {
                    case "1":
                        service.genGraph(5).Wait();
                        service.printGraph();
                        break;
                    case "2":
                        service.division().Wait();
                        service.printGraph();
                        break;
                    case "3":
                        service.printGraph();
                        break;
                    default: 
                        Console.WriteLine("Выбора ответа не существует"); break;
                }
            } while (true);



        }


    }
}
