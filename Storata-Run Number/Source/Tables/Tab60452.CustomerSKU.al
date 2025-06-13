table 60452 "Customer SKU"
{
    Caption = 'Customer SKU';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.") then begin
                    Rec."Item UOM" := Item."Base Unit of Measure";
                    Rec.Desciption := Item.Description;
                end;
            end;
        }
        field(3; "Item UOM"; Code[10])
        {
            Caption = 'Item UOM';
            Editable = false;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; Desciption; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Customer No.", "Item No.")
        {
            Clustered = true;
        }
    }
}
