table 50850 "50850_TabImportSalesHeader"
{
    Caption = 'Import Sales Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(3; "Order Reference"; Text[50])
        {
            Caption = 'Order Reference';
        }
        field(4; Location; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(5; "Delivery Mode"; Text[50])
        {
            Caption = 'Delivery Mode';
        }
        field(6; "Run Number"; Code[20])
        {
            Caption = 'Run Number';
            TableRelation = Runs;
            ValidateTableRelation = false;
        }
        field(7; "Shipping Date"; Date)
        {
            Caption = 'Shipping Date';
        }
        field(8; "Req. Receipt Date"; Date)
        {
            Caption = 'Req. Receipt Date';
        }
        field(9; "Error Description"; Text[1020])
        {
            Caption = 'Error Description';
            Editable = false;
        }
        field(10; Created; Boolean)
        {
            Caption = 'Created';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Order No.")
        {
            Clustered = true;
        }
    }
}
