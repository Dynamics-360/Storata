tableextension 50855 PF_ReturnReceiptHeaderExt extends "Return Receipt Header"
{

    // Add changes to table fields here
    fields
    {
        field(50850; SDN; Code[200])
        {
            Caption = 'SDN';
            DataClassification = ToBeClassified;
        }
        field(50851; "Truck Rego"; Code[200])
        {
            Caption = 'Truck Rego';
            DataClassification = ToBeClassified;
        }
        field(50852; "Work Description"; Blob)
        {
            Caption = 'Work Description';
            DataClassification = ToBeClassified;
        }
        field(505852; "Date Produced/UBD"; Date)
        {
            Caption = 'Date Produced/UBD';
            DataClassification = CustomerContent;
        }
        field(50583; "Warehouse Supervisor"; Code[20])
        {
            Caption = 'Warehouse Supervisor';
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Supervisor";
        }
        field(50864; "Store Man"; Text[100])
        {
            Caption = 'Store Man';
            DataClassification = CustomerContent;
        }
        field(50865; Carrier; Text[100])
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(50866; Driver; Text[100])
        {
            Caption = 'Driver';
            DataClassification = CustomerContent;
        }
        field(50867; Product; Option)
        {
            Caption = 'Product';
            OptionMembers = "Shell Eggs","Chilled Egg","Frozen Egg","Powder Egg","Boiled Eggs";
            DataClassification = CustomerContent;
        }
        field(50868; "Action Taken"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Return to Stock","Quarantine Area";
            OptionCaption = 'Return to Stock(Temperature is within specifications and the product safety and quality has not been compromised),Quarantine Area';
        }
        field(50869; "Action Take Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Action Take comment';
        }
        field(50870; "Reason for Return Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Return Comment';
        }
        field(50860; "Product Relv. Temp."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Product Relevant Temp.';
        }
        field(60450; "Run No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Run No.';
        }
    }

}