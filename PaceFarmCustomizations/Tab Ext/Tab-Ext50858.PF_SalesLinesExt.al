tableextension 50858 PF_SalesLines extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50850; "Pick Group"; Option)
        {
            Caption = 'Pick Groups';
            DataClassification = SystemMetadata;
            OptionMembers = " ","1","2","3","4","5";
        }
    }


}