pragma Ada_2012;
package body Chiffre is

   -------------------
   -- ValeurChiffre --
   -------------------

   function ValeurChiffre (C : in Type_Chiffre) return Integer is
   begin
      return Integer(C);
   end ValeurChiffre;

   -----------------
   -- EstInconnue --
   -----------------

   function EstInconnue (C : in Type_Chiffre) return Boolean is
   begin
      return ValeurChiffre(C) = -1;
   end EstInconnue;

   ----------------
   -- Complement --
   ----------------

   function Complement (C : in Type_Chiffre) return Type_Chiffre is
   begin
      if ValeurChiffre(C) = -1 then
         raise VALEUR_INCONNUE;
      elsif ValeurChiffre(C) = 0 then
         return UN;
      else
         return ZERO;
      end if;
   end Complement;

   ---------
   -- "=" --
   ---------

   function "=" (c1 : in Type_Chiffre; c2 : in Type_Chiffre) return Boolean is
   begin
      return ValeurChiffre(c1) = ValeurChiffre(c2);
   end "=";

end Chiffre;
