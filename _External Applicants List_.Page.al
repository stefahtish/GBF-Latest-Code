page 51507 "External Applicants List"
{
    CardPageID = "Applicant Card";
    PageType = List;
    SourceTable = Applicants2;
    SourceTableView = where("Applicant Type" = filter(External));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field';
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field';
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field';
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field';
                    ApplicationArea = All;
                }
                field(Employ; Rec.Employ)
                {
                    Caption = 'Qualified';
                    ToolTip = 'Specifies the value of the Qualified field';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ToolTip = 'Specifies the value of the Applicant Type field';
                    ApplicationArea = All;
                }
                field(Notified; Rec.Notified)
                {
                    ToolTip = 'Specifies the value of the Notified field';
                    ApplicationArea = All;
                }
                field(Applied; Rec.Applied)
                {
                    ToolTip = 'Specifies the value of the Applied field';
                    ApplicationArea = All;
                }
                field(Shortlist; Rec.Shortlist)
                {
                    ToolTip = 'Specifies the value of the Shortlist field';
                    ApplicationArea = All;
                }
                field(Interviewed; Rec.Interviewed)
                {
                    ToolTip = 'Specifies the value of the Interviewed field';
                    ApplicationArea = All;
                }
                // field(Qualified; Qualified)
                // {
                // }
            }
        }
    }
    actions
    {
    }
}
