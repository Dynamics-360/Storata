table 50851 "Import Sales Lines"
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
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; Warehouse; Code[20])
        {
            Caption = 'Warehouse';
        }
        field(10; Created; Boolean)
        {
            Caption = 'Created';
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
