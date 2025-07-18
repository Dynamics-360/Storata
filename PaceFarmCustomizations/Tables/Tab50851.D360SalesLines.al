table 50851 "50851_TabImportSalesLines"
{
    Caption = 'Import Sales Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            ValidateTableRelation = false;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; Location; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(10; Created; Boolean)
        {
            Caption = 'Created';
            Editable = false;
        }
        field(11; "Error Description"; Text[1020])
        {
            Caption = 'Error Description';
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
