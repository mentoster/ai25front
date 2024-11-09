import 'package:ai25front/src/generated/cardio.pbgrpc.dart';

class SetFileToProcessResponseData {
  // Static fields to hold response data
  static bool success = false;
  static String age = '';
  static bool pharm = false;
  static String label1 = '';
  static String label2 = '';
  static String label3 = '';
  static bool isMale = true;
  static bool isAnnotated = false;

  // Method to update the static fields from a SetFileToProcessResponse
  static void updateFromResponse(SetFileToProcessResponse response) {
    success = response.success;
    age = response.age;
    pharm = response.pharm;
    label1 = response.label1;
    isMale = response.isMale;
    label2 = response.label2;
    label3 = response.label3;
    isAnnotated = response.isAnnotated;
  }

  // Method to print all stored response data
  static void printResponseData() {
    print('Set file to process success: $success');
    print('Age: $age');
    print('Pharm: $pharm');
    print('Label1: $label1');
    print('Label2: $label2');
    print('Label3: $label3');
    print('Is Annotated: $isAnnotated');
  }
}
