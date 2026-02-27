using System;
using System.Collections.Generic;

namespace VizsgaLib;

public partial class Dealer
{
    public int DealerId { get; set; }

    public string Nev { get; set; } = null!;

    public string Terulet { get; set; } = null!;

    public int Jutalek { get; set; }

    public virtual ICollection<Hirdetes> Hirdetes { get; set; } = new List<Hirdetes>();
}
