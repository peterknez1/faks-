import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Scanner;

public class izziv4 {
    public static void main(String[] args){

        Scanner sc = new Scanner(System.in);
        int length = sc.nextInt();
        int[] arr = new int[length];
        int[] arr2 = new int[length];
        int[] arrCounters = new int[32];
        for(int i = 0; i < length; i++){
            int element = sc.nextInt();
            arr[i] = element;
            int bitCount = Integer.bitCount(element);
            arr2[i] = bitCount;
            arrCounters[bitCount - 1]++;
        }
        //System.out.println(Arrays.toString(arr));
        //System.out.println(Arrays.toString(arr2));
        //System.out.println(Arrays.toString(arrCounters));
        for(int i = 1; i < arrCounters.length; i++){
            arrCounters[i] += arrCounters[i - 1];
        }
        for(int i = 0; i < arrCounters.length; i++) {
            arrCounters[i]--;
        }
        //System.out.println(Arrays.toString(arrCounters));
        for(int i = arr.length - 1; i >= 0; i--){
            int element = arr[i];
            int elementBit = Integer.bitCount(element);
            int indeks = arrCounters[elementBit - 1];
            arr2[indeks] = element;
            System.out.print("(" + element + "," + indeks + ")\n");
            arrCounters[elementBit - 1]--;
        }
        for(int i = 0; i < arr2.length; i++){
            System.out.print(arr2[i] + " ");
        }


    }
}
