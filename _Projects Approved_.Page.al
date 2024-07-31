page 50387 "Projects Approved"
{
    Caption = 'Running Contracts';
    CardPageID = "Running Contract Card";
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Project Header";
    SourceTableView = WHERE(Stage = CONST(Running), "Direct Contract" = const(false));
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
                    ApplicationArea = all;
                    Caption = 'Contract Date';
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
