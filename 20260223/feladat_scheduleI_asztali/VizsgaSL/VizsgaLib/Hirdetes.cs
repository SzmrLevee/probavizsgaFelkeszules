using System;
using System.Collections.Generic;

namespace VizsgaLib;

public partial class Hirdetes
{
    public int HirdetesId { get; set; }

    public int TermekId { get; set; }

    public int DealerId { get; set; }

    public DateOnly Mikortol { get; set; }

    public DateOnly? Meddig { get; set; }

    public int Ar { get; set; }

    public int Mennyiseg { get; set; }

    public virtual Dealer Dealer { get; set; } = null!;

    public virtual Termek Termek { get; set; } = null!;
}
