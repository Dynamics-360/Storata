tableextension 50853 SalesShpHead extends "Sales Shipment Header"
{
    fields
    {
        field(50850; SDN; Code[200])
        {
            Caption = 'SDN';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header".SDN where("Order No." = field("Order No.")));
        }
        field(50851; "Truck Rego"; Code[200])
        {
            Caption = 'Truck Rego';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Truck Rego" where("Order No." = field("Order No.")));
        }
    }
}
