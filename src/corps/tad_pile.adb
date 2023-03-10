pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- construirePile --
   --------------------

   function construirePile return Type_Pile is
      P : Type_Pile;
   begin
      return P;
   end construirePile;

   -------------
   -- estVide --
   -------------

   function estVide (pile : in Type_Pile) return Boolean is
   begin
      return pile.nb_elements = 0;
   end estVide;

   -------------
   -- dernier --
   -------------

   function dernier (pile : in Type_Pile) return T is
   begin
      if estVide(pile) then
         raise PILE_VIDE;
      end if;
      return pile.elements(pile.nb_elements);
   end dernier;

   -------------
   -- empiler --
   -------------

   function empiler (pile : in Type_Pile; e : in T) return Type_Pile is
      nvlPile: Type_Pile;
   begin
      if pile.nb_elements = TAILLE_MAX then
         raise PILE_PLEINE;
      end if;
      nvlPile:=pile;
      nvlPile.nb_elements:=nvlPile.nb_elements + 1;
      nvlPile.elements(nvlPile.nb_elements) := e;
      return nvlPile;
   end empiler;

   -------------
   -- depiler --
   -------------

   function depiler (pile : in Type_Pile) return Type_Pile is
      nvlPile: Type_Pile;
   begin
      if estVide(pile) then
         raise PILE_VIDE;
      end if;
      nvlPile:=pile;
      nvlPile.nb_elements := nvlPile.nb_elements - 1;
      return nvlPile;
   end depiler;

end TAD_Pile;
