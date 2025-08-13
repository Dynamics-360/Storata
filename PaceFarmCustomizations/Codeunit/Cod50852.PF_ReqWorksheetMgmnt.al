codeunit 50852 "PF_ReqWorkSheet Mgmnt"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnBeforeCarryOutBatchActionCode, '', true, true)]
    local procedure MyCustomValidationBeforeActionMsg(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    begin
        ValidateRequisitionLinesBeforeCarryOut(RequisitionLine);
    end;

    local procedure ValidateRequisitionLinesBeforeCarryOut(CurrentLine: Record "Requisition Line")
    var
        RequisitionLine: Record "Requisition Line";
        ItemReference: Record "Item Reference";
    begin

        RequisitionLine.SetRange("Worksheet Template Name", CurrentLine."Worksheet Template Name");
        RequisitionLine.SetRange("Journal Batch Name", CurrentLine."Journal Batch Name");
        RequisitionLine.SetFilter("Accept Action Message", '%1', true);
        RequisitionLine.SETCURRENTKEY("Line No.");

        if RequisitionLine.FindFirst() then
            repeat

                if (RequisitionLine."No." = '') OR
                   (RequisitionLine."Location Code" = '') OR
                   (RequisitionLine.Quantity <= 0) or
                   (RequisitionLine."Direct Unit Cost" = 0) OR
                   (RequisitionLine."Vendor No." = '') OR
                   (RequisitionLine."Vendor Item No." = '') then
                    Error(
                        'Line %1 for item %2 has not been filled in completely. All lines must have an Item No., Location, Quantity > 0, Direct Unit Cost, Vendor No., and Vendor Item No.',
                        RequisitionLine."Line No.", RequisitionLine."No.");


                ItemReference.Reset();
                ItemReference.SetRange("Item No.", RequisitionLine."No.");
                ItemReference.SetRange("Reference Type No.", RequisitionLine."Vendor No.");
                ItemReference.SetRange("Reference No.", RequisitionLine."Vendor Item No.");
                if not ItemReference.FindFirst() then
                    Error(
                        'Line %1 for item %2 has a vendor item that is not setup in the item cross reference table.',
                        RequisitionLine."Line No.", RequisitionLine."No.");
            until RequisitionLine.Next() = 0;
    end;

}