page 50544 "Completed Travels"
{
    CardPageID = "Transport Request";
    PageType = List;
    SourceTable = "Travel Requests";
    SourceTableView = WHERE(Status = CONST(Released), "Transport Status" = CONST(Completed));
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
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Destinations; Rec.Destinations)
                {
                }
                field("No. of Personnel"; Rec."No. of Personnel")
                {
                }
                field("Trip Planned Start Date"; Rec."Trip Planned Start Date")
                {
                    Caption = 'Planned Start Date';
                }
                field("Trip Planned End Date"; Rec."Trip Planned End Date")
                {
                    Caption = 'Planned End Date';
                }
                field("Start Date"; Rec."Start Date")
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
