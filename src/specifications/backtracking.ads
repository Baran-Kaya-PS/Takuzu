with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;
with Pile_Coor; use Pile_Coor;
with Affichage; use Affichage;

package backtracking is

   -- Verifie si la grille G est correcte en ignorant les inconnues
   function grilleCorrecte (G: in Type_Grille) return Boolean;

   -- Complete la grille G par methode de backtracking
   function retourSurTrace (G: in Type_Grille) return Type_Grille;

end backtracking;
