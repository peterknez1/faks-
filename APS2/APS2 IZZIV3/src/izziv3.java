import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class izziv3 {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int m = sc.nextInt();
        int[] a = new int[n];
        int[] b = new int[m];
        for(int i = 0; i < n; i++){
            a[i] = sc.nextInt();
        }
        for(int i = 0; i < m; i++){
            b[i] = sc.nextInt();
        }
        int[] c = new int[n + m];

        int indeksa = 0;
        int indeksb = 0;
        int indeksc = 0;
        while(indeksa != n - 1 || indeksb != m - 1){
            if(indeksa == n - 1){
                for(int i = indeksb; i < m - 1; i++){
                    c[indeksc] = b[i];
                    indeksc++;
                    indeksb++;
                }

            }
            if(indeksb == m - 1){
                for(int i = indeksa; i < n - 1; i++){
                    c[indeksc] = a[i];
                    indeksc++;
                    indeksa++;
                }
            }
            if(n != 0 && m != 0){
                if(a[indeksa] <= b[indeksb]){
                    c[indeksc] = a[indeksa];
                    indeksa++;
                    indeksc++;
                }
                else{
                    c[indeksc] = b[indeksb];
                    indeksb++;
                    indeksc++;
                }
            }
        }
        System.out.println(Arrays.toString(c));

    }
}
