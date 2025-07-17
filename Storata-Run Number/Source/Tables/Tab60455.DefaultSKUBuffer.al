table 60455 DefaultSKUBuffer
{
    Caption = 'DefaultSKUBuffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
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
        field(2; "Item UOM"; Code[10])
        {
            Caption = 'Item UOM';
            Editable = false;
        }
        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(4; Desciption; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}
