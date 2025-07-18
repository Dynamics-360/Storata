tableextension 50856 ReqWorkShetExt extends "Requisition Wksh. Name"
{
    fields
    {
        field(50850; Lines; Integer)
        {
            Caption = 'Lines';
            FieldClass = FlowField;
            CalcFormula = count("Requisition Line" where("Journal Batch Name" = field(Name), Description = filter(<> '')));
        }
    }
}
