reportextension 50857 TransferOrderExt extends "Transfer Order"
{
    dataset
    {
        // Add changes to dataitems and columns here
        modify("Transfer Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                Item: Record Item;
            begin
                Clear(ItemPickCode);
                If Item.get("Item No.") then
                    ItemPickCode := Item."Pick Code";
            end;
        }
        add("Transfer Line")
        {
            column(Pick_Code; ItemPickCode)
            {

            }
        }
    }

    rendering
    {
        layout("Transfer Order - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50857_PFTransferOrder.rdl';
        }
    }
    var
        ItemPickCode: Code[20];
}