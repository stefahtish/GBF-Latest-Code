page 51001 "Contract List Consol"
{
    CardPageID = Contract_Card;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Contract1;
    SourceTableView = WHERE("Contract Category" = CONST(Consultants));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Contract Name"; Rec."Contract Name")
                {
                }
                field("Contract Category"; Rec."Contract Category")
                {
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    actions
    {
    }
}
