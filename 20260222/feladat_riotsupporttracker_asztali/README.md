# LoL Support – Asztali feladat (Szomor Levente SZFT5)

Az alábbi fájl **feladat → megoldás** párokat tartalmaz, a korábbi C# asztali minták stílusában (EF Core scaffold + CLI + WPF MVVM).

---

## Feladat 1 – Adatbázis import

Importáld a mellékelt `lol_support_MY.sql` fájlt a `lol_support` adatbázisba (phpMyAdmin).

### Megoldás 1

- Hozd létre az adatbázist: `lol_support`
- Importáld a `lol_support_MY.sql` forrást.

---

## Feladat 2 – Library projekt és scaffold

Hozz létre egy `LoLSupport_Lib` library projektet, telepítsd a szükséges NuGet csomagokat, majd scaffoldold a DbContextet és az entitásokat.

### Megoldás 2 – Scaffold parancs (Package Manager Console)

```powershell
Scaffold-DbContext "database=lol_support;server=127.0.0.1;uid=root;pwd=root_p_ssW0rd;port=3306" Pomelo.EntityFrameworkCore.MySql -OutputDir . -Context LoLSupportContext -Force
```

---

## Feladat 3 – Számított tulajdonság a Hibajegy entitásban

A `Hibajegy` osztályba készíts számított tulajdonságot: `SulyossagiPont`.
- értéke: `sulyossag * 10`
- ha van hős és a hős nyerési aránya **52% felett** van, akkor +5 pont

### Megoldás 3 – Hibajegy.cs (részlet)

```csharp
public int SulyossagiPont => (Sulyossag!.Value * 10)
    + (Hos != null && Hos.NyeresiArany > 52 ? 5 : 0);
```

---

## Feladat 4 – CLI projekt

Hozz létre egy konzolos projektet: `LoLSupport`.
A Program.cs-ben oldd meg az alábbi feladatokat.

### 5. feladat
Írd ki, hogy **hány darab** `closed` státuszú hibajegy van.

### 6. feladat
Kérj be a felhasználótól egy hős nevet.
- Ha nincs ilyen hős: `\tIlyen néven nem található hős`
- Különben:
  - írd ki a hős szerepét és nyerési arányát
  - majd listázd ki a hőshöz tartozó hibajegyeket (bármely státusz), ügyintéző névvel és `SulyossagiPont`-tal

### 7. feladat
Listázd ki az ügyintézőket ABC sorrendben, és hogy hány **open** státuszú hibajegyük van.
Formátum:
`\tNév (REGIO) - X db`

### Megoldás 4 – Program.cs

```csharp
// See https://aka.ms/new-console-template for more information
using Microsoft.EntityFrameworkCore;
using LoLSupport_Lib;

LoLSupportContext context = new();

Console.WriteLine($"5. feladat: Lezárt hibajegyek száma: {context.Hibajegies.Count(x => x.Statusz == "closed")} db");

Console.Write("6. feladat: Hős neve: ");
string nev = Console.ReadLine()! ?? "";

var hos = context.Hos.FirstOrDefault(x => x.Nev == nev);
if (hos == null)
{
    Console.WriteLine("\tIlyen néven nem található hős");
}
else
{
    var szerep = context.Szereps.First(x => x.SzerepId == hos.SzerepId);

    Console.WriteLine($"\tSzerep: {szerep.Megnevezes}");
    Console.WriteLine($"\tNyerési arány: {hos.NyeresiArany}%");

    foreach (var item in context.Hibajegies
        .Where(x => x.HosId == hos.HosId)
        .Include(x => x.Ugyintezo))
    {
        string ugy = item.Ugyintezo == null ? "-" : item.Ugyintezo.Nev!;
        Console.WriteLine($"\t{ugy} - {item.SulyossagiPont} pont ({item.Statusz})");
    }
}

Console.WriteLine("7. feladat: Open hibajegyek ügyintézőnként:");
foreach (var item in context.Hibajegies
    .Where(x => x.Statusz == "open" && x.UgyintezoId != null)
    .GroupBy(x => x.Ugyintezo!.Nev)
    .Select(x => new { Nev = x.Key, Db = x.Count() })
    .OrderBy(x => x.Nev))
{
    var regio = context.Ugyintezos.First(x => x.Nev == item.Nev).Regio;
    Console.WriteLine($"\t{item.Nev} ({regio}) - {item.Db} db");
}
```

---

## Feladat 5 – WPF GUI

Hozz létre egy WPF projektet: `LoLSupportGui`.

### GUI működés

- 1. ComboBox: ügyintézők (Név)
- 2. ComboBox: a kiválasztott ügyintézőhöz tartozó hibajegyek címe (leírás első 40 karaktere), csak `open` és `investigating` státuszok
- Ha kiválasztunk egy hibajegyet, jelenjen meg egy GroupBox-ban:
  - Hős neve (ha nincs: `-`)
  - Státusz
  - Súlyosság
  - Súlyossági pont
  - Dátum
  - Leírás (teljes)

### Megoldás 5 – MainWindow.xaml

```xml
<Window x:Class="LoLSupportGui.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:LoLSupportGui"
        mc:Ignorable="d"
        Title="LoL Support - Hibajegyek" Height="520" Width="500">
    <Window.DataContext>
        <local:MainWindowViewModel/>
    </Window.DataContext>

    <Grid Margin="5">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <Label Content="Ügyintéző" Grid.Row="0" Grid.Column="0"/>
        <ComboBox Grid.Row="0" Grid.Column="1"
                  ItemsSource="{Binding Ugyintezok}"
                  DisplayMemberPath="Nev"
                  SelectedItem="{Binding ValasztottUgyintezo}"/>

        <Label Content="Hibajegy" Grid.Row="1" Grid.Column="0"/>
        <ComboBox Grid.Row="1" Grid.Column="1"
                  ItemsSource="{Binding Hibajegyek}"
                  DisplayMemberPath="RovidCim"
                  SelectedItem="{Binding ValasztottHibajegy}"/>

        <GroupBox Header="Adatok" Grid.Row="2" Grid.Column="0" Grid.ColumnSpan="2"
                  Visibility="{Binding AdatokVisible}">
            <ScrollViewer VerticalScrollBarVisibility="Auto">
                <StackPanel Margin="5" >
                    <Label Content="Hős"/>
                    <TextBox Text="{Binding HosNev}" IsReadOnly="True"/>

                    <Label Content="Státusz"/>
                    <TextBox Text="{Binding Statusz}" IsReadOnly="True"/>

                    <Label Content="Súlyosság"/>
                    <TextBox Text="{Binding Sulyossag}" IsReadOnly="True"/>

                    <Label Content="Súlyossági pont"/>
                    <TextBox Text="{Binding Pont}" IsReadOnly="True"/>

                    <Label Content="Dátum"/>
                    <TextBox Text="{Binding Datum}" IsReadOnly="True"/>

                    <Label Content="Leírás"/>
                    <TextBox Text="{Binding Leiras}" IsReadOnly="True" TextWrapping="Wrap" Height="140"/>
                </StackPanel>
            </ScrollViewer>
        </GroupBox>
    </Grid>
</Window>
```

### Megoldás 5 – MainWindowViewModel.cs

```csharp
using LoLSupport_Lib;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;

namespace LoLSupportGui;

public class MainWindowViewModel : INotifyPropertyChanged
{
    readonly LoLSupportContext context = new();

    private Ugyintezo? valasztottUgyintezo;
    private HibajegyVm? valasztottHibajegy;

    public event PropertyChangedEventHandler? PropertyChanged;
    public void Notify([CallerMemberName] string propName = "")
        => PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));

    public List<Ugyintezo> Ugyintezok { get; init; }
    public ObservableCollection<HibajegyVm> Hibajegyek { get; init; }

    public string HosNev { get; set; } = "";
    public string Statusz { get; set; } = "";
    public int Sulyossag { get; set; }
    public int Pont { get; set; }
    public string Datum { get; set; } = "";
    public string Leiras { get; set; } = "";

    public Ugyintezo? ValasztottUgyintezo
    {
        get => valasztottUgyintezo;
        set
        {
            valasztottUgyintezo = value;
            Hibajegyek.Clear();

            if (valasztottUgyintezo != null)
            {
                var list = context.Hibajegies
                    .Where(x => x.UgyintezoId == valasztottUgyintezo.UgyintezoId
                             && (x.Statusz == "open" || x.Statusz == "investigating"))
                    .OrderByDescending(x => x.Datum)
                    .Select(x => new HibajegyVm
                    {
                        HibajegyId = x.HibajegyId,
                        RovidCim = x.Leiras.Length > 40 ? x.Leiras.Substring(0, 40) + "..." : x.Leiras
                    });

                foreach (var item in list)
                    Hibajegyek.Add(item);
            }

            Notify(nameof(VanHibajegy));
        }
    }

    public HibajegyVm? ValasztottHibajegy
    {
        get => valasztottHibajegy;
        set
        {
            valasztottHibajegy = value;

            if (valasztottHibajegy != null)
            {
                var jegy = context.Hibajegies
                    .Include(x => x.Hos)
                    .First(x => x.HibajegyId == valasztottHibajegy.HibajegyId);

                HosNev = jegy.Hos == null ? "-" : jegy.Hos.Nev!;
                Statusz = jegy.Statusz!;
                Sulyossag = jegy.Sulyossag;
                Pont = jegy.SulyossagiPont;
                Datum = jegy.Datum.ToString();
                Leiras = jegy.Leiras;
            }

            Notify(nameof(HosNev));
            Notify(nameof(Statusz));
            Notify(nameof(Sulyossag));
            Notify(nameof(Pont));
            Notify(nameof(Datum));
            Notify(nameof(Leiras));
            Notify(nameof(AdatokVisible));
        }
    }

    public bool VanHibajegy => Hibajegyek.Count != 0;
    public Visibility AdatokVisible => ValasztottHibajegy == null ? Visibility.Hidden : Visibility.Visible;

    public MainWindowViewModel()
    {
        Ugyintezok = [.. context.Ugyintezos.OrderBy(x => x.Nev)];
        Hibajegyek = new();
    }
}

public class HibajegyVm
{
    public int HibajegyId { get; set; }
    public string RovidCim { get; set; } = "";
}
```

---
