

using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;

namespace Sppr
{

    public class Programm
    {

        public static void Main(String[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddControllers();
            var app = builder.Build();

            app.UseAuthorization();
            app.MapControllers(); 
            app.UseRouting();
            
            app.Run();
        }

    }

}