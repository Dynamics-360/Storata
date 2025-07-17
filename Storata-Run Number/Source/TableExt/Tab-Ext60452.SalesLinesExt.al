tableextension 60452 SalesLinesExt extends "Sales Line"
{
    fields
    {
        field(60450; "Run No."; Code[20])
        {
            Caption = 'Run No.';
            DataClassification = ToBeClassified;
            TableRelation = Runs;
        }
    }
}
