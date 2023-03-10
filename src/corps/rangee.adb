pragma Ada_2012;
package body Rangee is

   ----------------------
   -- ConstruireRangee --
   ----------------------

   function ConstruireRangee (T : in Integer) return Type_Rangee is
      rangee: Type_Rangee;
   begin
      rangee.Taille:=T;
      for i in 1..T loop
         rangee.R(i):=INCONNU;
      end loop;
      return rangee;
   end ConstruireRangee;

   -------------
   -- EstVide --
   -------------

   function EstVide (R : in Type_Rangee) return Boolean is
   begin
      for i in 1..R.taille loop
         if not EstInconnue(R.R(i)) then
            return False;
         end if;
      end loop;
      return True;
   end EstVide;

   ----------------
   -- EstRemplie --
   ----------------

   function EstRemplie (R : in Type_Rangee) return Boolean is
   begin
      for i in 1..R.taille loop
         if EstInconnue(R.R(i)) then
            return False;
         end if;
      end loop;
      return True;
   end EstRemplie;

   ------------
   -- Taille --
   ------------

   function Taille (R : in Type_Rangee) return Integer is
   begin
      return R.Taille;
   end Taille;

   --------------------
   -- ObtenirChiffre --
   --------------------

   function ObtenirChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      return R.R(I);
   end ObtenirChiffre;

   --------------------------
   -- nombreChiffresConnus --
   --------------------------

   function nombreChiffresConnus (R : in Type_Rangee) return Integer is
      nbConnues: integer;
   begin
      nbConnues:=0;
      for i in 1..R.taille loop
         if not EstInconnue(R.R(i)) then
            nbConnues:=nbConnues + 1;
         end if;
      end loop;
      return nbConnues;
   end nombreChiffresConnus;

   ----------------------------
   -- nombreChiffresDeValeur --
   ----------------------------

   function nombreChiffresDeValeur
     (R : in Type_Rangee; V : in Type_Chiffre) return Integer
   is
      nbChiffres: integer;
   begin
      nbChiffres:=0;
      for i in 1..R.taille loop
         if R.R(i) = V then
            nbChiffres:=nbChiffres + 1;
         end if;
      end loop;
      return nbChiffres;
   end nombreChiffresDeValeur;

   ---------------------
   -- chiffreDeDroite --
   ---------------------

   function chiffreDeDroite
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      if I = Taille(E) then
         return INCONNU;
      else
         return E.R(I+1);
      end if;
   end chiffreDeDroite;

   ---------------------
   -- chiffreDeGauche --
   ---------------------

   function chiffreDeGauche
     (E : in Type_Rangee; I : in Integer) return Type_Chiffre
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      if I = 1 then
         return INCONNU;
      else
         return E.R(I-1);
      end if;
   end chiffreDeGauche;

   -----------------------------------
   -- SontDeuxChiffresDeDroiteEgaux --
   -----------------------------------

   function SontDeuxChiffresDeDroiteEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I < 1 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      if chiffreDeDroite(E,I) /= INCONNU then
         if I+1 = Taille(E) then
            return False;
         else
            return E.R(I+1) = E.R(I+2);
         end if;
      end if;
      return False;
   end SontDeuxChiffresDeDroiteEgaux;

   -----------------------------------
   -- SontDeuxChiffresDeGaucheEgaux --
   -----------------------------------

   function SontDeuxChiffresDeGaucheEgaux
     (E : in Type_Rangee; I : in Integer) return Boolean
   is
   begin
      if I < 2 or I > E.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      if chiffreDeGauche(E,I) /= INCONNU then
         if I-1 = 1 then
            return False;
         else
            return E.R(I-1) = E.R(I-2);
         end if;
      end if;
      return False;
   end SontDeuxChiffresDeGaucheEgaux;

   --------------------
   -- AjouterChiffre --
   --------------------

   function AjouterChiffre
     (R : in Type_Rangee; I : in Integer; C : in Type_Chiffre)
      return Type_Rangee
   is
      E: Type_rangee;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      E:=R;
      E.R(I) := C;
      return E;
   end AjouterChiffre;

   --------------------
   -- RetirerChiffre --
   --------------------

   function RetirerChiffre
     (R : in Type_Rangee; I : in Integer) return Type_Rangee
   is
      E: Type_rangee;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      end if;

      E:=R;
      E.R(I) := INCONNU;
      return E;
   end RetirerChiffre;

end Rangee;
