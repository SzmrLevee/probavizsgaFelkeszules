using System;
using System.Collections.Generic;

namespace VizsgaLib;

public partial class Kategoria
{
    public int KategoriaId { get; set; }

    public string Megnevezes { get; set; } = null!;

    public virtual ICollection<Termek> Termeks { get; set; } = new List<Termek>();
}
