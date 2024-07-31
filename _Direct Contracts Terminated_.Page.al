page 51486 "Direct Contracts Terminated"
{
    CardPageID = "Direct Contract Card";
    Caption = 'Direct Contracts Terminated List';
    Editable = false;
    PageType = List;
    InsertAllowed = false;
    SourceTable = "Project Header";
    //SourceTableView = WHERE(Status = CONST("Terminated Contracts"), "Direct Contract" = const(true));
    SourceTableView = WHERE(Stage = const(Termination), "Direct Contract" = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Contract Name';
                    ApplicationArea = all;
                }
                field("Project Date"; Rec."Project Date")
                {
                    Caption = 'Contract Date';
                    ApplicationArea = all;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = all;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = all;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = all;
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = all;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
}
