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
    }
    
}