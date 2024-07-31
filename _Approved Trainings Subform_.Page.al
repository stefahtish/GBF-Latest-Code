page 50579 "Approved Trainings Subform"
{
    CardPageID = "Training Request Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Training Request";
    SourceTableView = WHERE(Status = CONST(Released));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Designation; Rec.Designation)
                {
                }
            }
        }
    }
    actions
    {
    }
}
