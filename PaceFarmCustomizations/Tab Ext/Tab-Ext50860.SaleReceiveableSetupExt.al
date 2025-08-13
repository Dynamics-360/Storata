tableextension 50860 SaleReceiveableSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50850; "Item Journal Template"; Code[20])
        {
            Caption = 'Item Journal Template';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50851; "Item Journal Batch"; Code[20])
        {
            Caption = 'Item Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch" where("Journal Template Name" = field("Item Journal Template"));
        }
    }
}
