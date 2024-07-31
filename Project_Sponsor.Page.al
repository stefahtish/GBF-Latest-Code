page 51346 Project_Sponsor
{
    PageType = ListPart;
    Caption = 'Project Sponsors';
    SourceTable = ProjectManagementSponsors;
    ApplicationArea = All;

    //AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(FullName; Rec.FullName)
                {
                    ToolTip = 'Specifies the value of the FullName field.';
                    ApplicationArea = All;
                    Caption = 'Full Name';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
                    ApplicationArea = All;
                }
                field(EmailAddress; Rec.EmailAddress)
                {
                    ToolTip = 'Specifies the value of the EmailAddress field.';
                    ApplicationArea = All;
                    Caption = 'Email Address';
                }
                field(SponsorType; Rec.SponsorType)
                {
                    ToolTip = 'Specifies the value of the SponsorType field.';
                    ApplicationArea = All;
                    Caption = 'Sponsor Type';
                }
            }
        }
    }
}
