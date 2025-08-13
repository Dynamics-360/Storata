table 50854 "Product Reviewer"
{
    Caption = 'Product Reviewer';
    DataClassification = CustomerContent;
    LookupPageId = "Product Reviewer";
    DrillDownPageId = "Product Reviewer";

    fields
    {
        field(1; "Product Reviewer No."; Code[20])
        {
            Caption = 'Product Reviewer No.';
        }
        field(2; "Product Reviewer Name"; Text[100])
        {
            Caption = 'Supervisor Name';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
        }
    }
    keys
    {
        key(PK; "Product Reviewer No.")
        {
            Clustered = true;
        }
    }
}
