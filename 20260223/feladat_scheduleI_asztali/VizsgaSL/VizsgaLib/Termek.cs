using System;
using System.Collections.Generic;

namespace VizsgaLib;

public partial class Termek
{
    public int TermekId { get; set; }

    public int KategoriaId { get; set; }

    public string Nev { get; set; } = null!;

    public int ThcSzazalek { get; set; }

    public string Leiras { get; set; } = null!;

    public virtual ICollection<Hirdetes> Hirdetes { get; set; } = new List<Hirdetes>();

    public virtual Kategoria Kategoria { get; set; } = null!;
}
