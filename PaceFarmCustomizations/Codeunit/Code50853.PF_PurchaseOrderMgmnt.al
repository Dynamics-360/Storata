codeunit 50853 "PF_PurchaseOrder Mgmnt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', true, true)]
    local procedure ValidateOnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    begin
        ValidatePurchaseLines(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeReleasePurchaseDoc, '', true, true)]
    local procedure ValidateOnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    begin
        ValidatePurchaseLines(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnBeforeRunWorkflowOnSendPurchaseDocForApproval, '', true, true)]
    local procedure ValidateOnBeforeRunWorkflowOnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        ValidatePurchaseLines(PurchaseHeader);
    end;

    local procedure ValidatePurchaseLines(PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        ItemReference: Record "Item Reference";
    begin
        if not PurchHeader."Created From Amino" then
            exit;

        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");

        if PurchLine.FindSet() then
            repeat
                if (PurchLine.Type = PurchLine.Type::Item) and
                   ((PurchLine."No." = '') or
                    (PurchLine."Location Code" = '') or
                    (PurchLine.Quantity <= 0) or
                    (PurchLine."Direct Unit Cost" = 0) or
                    (PurchLine."Buy-from Vendor No." = '') or
                    (PurchLine."Vendor Item No." = '')) then
                    Error(
                        'Line %1 for item %2 has not been filled in completely. All lines must have an Item No., Location, Quantity > 0, Direct Unit Cost, Vendor No., and Vendor Item No.',
                        PurchLine."Line No.", PurchLine."No.");

                ItemReference.Reset();
                ItemReference.SetRange("Item No.", PurchLine."No.");
                ItemReference.SetRange("Reference Type No.", PurchLine."Buy-from Vendor No.");
                ItemReference.SetRange("Reference No.", PurchLine."Vendor Item No.");
                if not ItemReference.FindFirst() then
                    Error(
                        'Line %1 for item %2 has a vendor item that is not setup in the item cross reference table.',
                        PurchLine."Line No.", PurchLine."No.");
            until PurchLine.Next() = 0;
    end;
}