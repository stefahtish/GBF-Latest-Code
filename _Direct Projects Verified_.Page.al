page 51485 "Direct Projects Verified"
{
    CardPageID = "Direct Contract Card";
    Caption = 'Contracts verified';
    Editable = false;
    PageType = List;
    InsertAllowed = false;
    SourceTable = "Project Header";
    SourceTableView = where(Stage = const(Verification), "Direct Contract" = const(true));
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
                field("Nature Of Contract"; Rec."Nature Of Contract")
                {
                    ApplicationArea = all;
                    Caption = 'Contract Name';
                }
                field("Project Date"; Rec."Project Date")
                {
                    ApplicationArea = all;
                    Caption = 'Contract date';
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
