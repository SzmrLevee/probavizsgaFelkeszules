using Microsoft.EntityFrameworkCore;
using VizsgaLib;

ScheduleiContext context = new();

//4. feladat:
Console.WriteLine($"Időszakosan elérhető hirdetések száma: {context.Hirdetes.Count(x=>x.Meddig!=null)}");

//5. feladat:
Console.Write("Kérek egy terméknevet: ");
string termeknev = (Console.ReadLine()! ?? "").Trim();
var termek = context.Termeks
    .Include(x=>x.Kategoria)
    .Include(x=>x.Hirdetes)
    .ThenInclude(x=>x.Dealer)
    .AsEnumerable()
    .FirstOrDefault(x=>x.Nev==termeknev);
if (termek == null) {
    Console.WriteLine("\tNem található ilyen termék");
}
else
{
    Console.WriteLine($"\tKategória: {termek.Kategoria?.Megnevezes}, \n\tTHC: {termek.ThcSzazalek}%, \n\tHirdetés: {termek.Hirdetes.Count}");
    foreach (var h in termek.Hirdetes)
    {
        Console.WriteLine($"\t- Ár: {h.Ar} Ft, Mennyiség: {h.Mennyiseg}, Dealer: {h.Dealer.Nev}, Jutalék: {h.Jutalek} Ft");
    }
}

//6.feladat:
Console.WriteLine("Dealerek és hirdetéseik: ");
var lista = context.Dealers
    .Select(d => new
    {
        Nev = d.Nev,
        AktivHirdetesDb = d.Hirdetes.Count(h => h.Meddig == null)
    })
    .OrderBy(x => x.Nev)
    .ToList();

foreach(var item in lista)
{
    Console.WriteLine($"\t{item.Nev}: {item.AktivHirdetesDb} db hirdetés");
}