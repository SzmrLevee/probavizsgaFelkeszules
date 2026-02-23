using LolSupportLib;
using Microsoft.EntityFrameworkCore;

LolSupportContext context = new();
Console.WriteLine($"4. feladat: {context.Hibajegies.Count(x => x.Statusz == "closed")} lezárt hibajegy található");

Console.Write("5. feladat: A hős neve: ");
string hosNev = Console.ReadLine()! ?? "";

var hos = context.Hos
    .Include(x => x.Szerep)
    .FirstOrDefault(x => x.Nev == hosNev);

if (hos == null)
{
    Console.WriteLine("\tIlyen néven nem található hős");
}
else
{
    Console.WriteLine($"\tSzerep: {hos.Szerep!.Megnevezes}");
    Console.WriteLine($"\tNyerési arány: {hos.NyeresiArany}%");

    foreach (var h in context.Hibajegies
        .Where(x => x.HosId == hos.HosId)
        .Include(x => x.Ugyintezo)
        .OrderBy(x => x.Datum))
    {
        string ugyNev = h.Ugyintezo == null ? "-" : h.Ugyintezo.Nev!;
        Console.WriteLine($"\t{h.Datum:yyyy.MM.dd} - {ugyNev} - {h.Pontszam} pont");
    }
}

Console.WriteLine("6. feladat: Open státuszú hibajegyek ügyintézőnként:");

foreach (var item in context.Ugyintezos
    .OrderBy(x => x.Nev)
    .Select(x => new
    {
        Nev = x.Nev,
        Regio = x.Regio,
        Db = context.Hibajegies.Count(h => h.UgyintezoId == x.UgyintezoId && h.Statusz == "open")
    }))
{
    Console.WriteLine($"\t{item.Nev} ({item.Regio}) - {item.Db} db");
}