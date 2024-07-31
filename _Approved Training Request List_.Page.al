page 50428 "Approved Training Request List"
{
    CardPageID = "Training Request Card";
    Editable = false;
    PageType = List;
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
                field("No. Of Days"; Rec."No. Of Days")
                {
                }
                field(Destination; Rec.Destination)
                {
                }
                field(Venue; Rec.Venue)
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
