using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace LolSupportLib;

public partial class LolSupportContext : DbContext
{
    public LolSupportContext()
    {
    }

    public LolSupportContext(DbContextOptions<LolSupportContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Hibajegy> Hibajegies { get; set; }

    public virtual DbSet<Hos> Hos { get; set; }

    public virtual DbSet<Szerep> Szereps { get; set; }

    public virtual DbSet<Ugyintezo> Ugyintezos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseMySql("database=lol_support;server=127.0.0.1;uid=root;pwd=root_p_ssW0rd;port=3306", Microsoft.EntityFrameworkCore.ServerVersion.Parse("9.3.0-mysql"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_hungarian_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Hibajegy>(entity =>
        {
            entity.HasKey(e => e.HibajegyId).HasName("PRIMARY");

            entity.ToTable("hibajegy");

            entity.HasIndex(e => e.HosId, "hos_id");

            entity.HasIndex(e => e.UgyintezoId, "ugyintezo_id");

            entity.Property(e => e.HibajegyId).HasColumnName("hibajegy_id");
            entity.Property(e => e.Datum).HasColumnName("datum");
            entity.Property(e => e.HosId).HasColumnName("hos_id");
            entity.Property(e => e.Leiras)
                .HasMaxLength(200)
                .HasColumnName("leiras");
            entity.Property(e => e.Statusz)
                .HasMaxLength(20)
                .HasDefaultValueSql("'open'")
                .HasColumnName("statusz");
            entity.Property(e => e.Sulyossag).HasColumnName("sulyossag");
            entity.Property(e => e.UgyintezoId).HasColumnName("ugyintezo_id");

            entity.HasOne(d => d.Hos).WithMany(p => p.Hibajegies)
                .HasForeignKey(d => d.HosId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("hibajegy_ibfk_1");

            entity.HasOne(d => d.Ugyintezo).WithMany(p => p.Hibajegies)
                .HasForeignKey(d => d.UgyintezoId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("hibajegy_ibfk_2");
        });

        modelBuilder.Entity<Hos>(entity =>
        {
            entity.HasKey(e => e.HosId).HasName("PRIMARY");

            entity.ToTable("hos");

            entity.HasIndex(e => e.SzerepId, "szerep_id");

            entity.Property(e => e.HosId).HasColumnName("hos_id");
            entity.Property(e => e.Nev)
                .HasMaxLength(30)
                .HasColumnName("nev");
            entity.Property(e => e.NyeresiArany).HasColumnName("nyeresi_arany");
            entity.Property(e => e.SzerepId).HasColumnName("szerep_id");
            entity.Property(e => e.ValasztasiArany).HasColumnName("valasztasi_arany");

            entity.HasOne(d => d.Szerep).WithMany(p => p.Hos)
                .HasForeignKey(d => d.SzerepId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("hos_ibfk_1");
        });

        modelBuilder.Entity<Szerep>(entity =>
        {
            entity.HasKey(e => e.SzerepId).HasName("PRIMARY");

            entity.ToTable("szerep");

            entity.Property(e => e.SzerepId).HasColumnName("szerep_id");
            entity.Property(e => e.Megnevezes)
                .HasMaxLength(20)
                .HasColumnName("megnevezes");
        });

        modelBuilder.Entity<Ugyintezo>(entity =>
        {
            entity.HasKey(e => e.UgyintezoId).HasName("PRIMARY");

            entity.ToTable("ugyintezo");

            entity.Property(e => e.UgyintezoId).HasColumnName("ugyintezo_id");
            entity.Property(e => e.Nev)
                .HasMaxLength(30)
                .HasColumnName("nev");
            entity.Property(e => e.Regio)
                .HasMaxLength(10)
                .HasColumnName("regio");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
