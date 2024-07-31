page 50234 "FA Disposal Quote List"
{
    CardPageID = "FA Disposal Quote Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Request";
    SourceTableView = WHERE("Process Type" = CONST("FA Disposal Quote"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("FA Disposal No."; Rec."FA Disposal No.")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
    actions
    {
    }
}
