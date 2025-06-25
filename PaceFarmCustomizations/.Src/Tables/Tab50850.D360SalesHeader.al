table 50850 "Import Sales Header"
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
        }
        field(3; "Order Reference"; Text[50])
        {
            Caption = 'Order Reference';
        }
        field(4; Warehouse; Code[20])
        {
            Caption = 'Warehouse';
        }
        field(5; "Delivery Mode"; Text[50])
        {
            Caption = 'Delivery Mode';
        }
        field(6; "Run Number"; Code[20])
        {
            Caption = 'Run Number';
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
    trigger OnDelete()
    var
        ImportSalLines: Record "Import Sales Lines";
    begin
        ImportSalLines.Reset();
        ImportSalLines.SetRange("Order No.", Rec."Order No.");
        if ImportSalLines.FindSet() then
            ImportSalLines.DeleteAll();
    end;
}
