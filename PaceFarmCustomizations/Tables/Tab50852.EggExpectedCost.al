table 50852 "Storata Egg Expected Cost"
{
    Caption = 'Egg Expected Cost';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; "Farming Method"; Code[10])
        {
            Caption = 'Farming Method';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('FARMMETHOD'));
        }
        field(3; "Grading Floor"; Code[20])
        {
            Caption = 'Grading Floor';
            TableRelation = Location;
        }
        field(4; "Upgraded per Egg Cost"; Decimal)
        {
            Caption = 'Upgraded per Egg Cost';
        }
        field(5; "Packaging per Egg Cost"; Decimal)
        {
            Caption = 'Packaging per Egg Cost';

        }
        field(6; "Grading Overheads per Egg Cost"; Decimal)
        {
            Caption = 'Grading Overheads per Egg Cost';
        }
    }
    keys
    {
        key(PK; "Item No.", "Farming Method", "Grading Floor")
        {
            Clustered = true;
        }
    }
}
