page 51142 "Applicant outlets card"
{
    Caption = 'Outlets card';
    PageType = Card;
    SourceTable = "License Applicants Branches";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application no"; Rec."Application no")
                {
                    Visible = false;
                }
                field(Outlet; Rec.Outlet)
                {
                    ApplicationArea = All;
                }
                field("Category of outlets"; Rec."Category of outlets")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Subcounty; Rec.Subcounty)
                {
                    ApplicationArea = All;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Station; Rec.Station)
                {
                    Caption = 'Branch';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Physical Location"; Rec."Physical Location")
                {
                    ApplicationArea = All;
                }
                field(Salutation; Rec.Salutation)
                {
                }
                field("Contact person"; Rec."Contact person")
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
            }
            part("License Applicant Products"; "License Applicant Products")
            {
                Caption = 'Nature of Produce';
                SubPageLink = "Application no" = field("Application no"), Outlet = field(Outlet);
            }
            part("Applicant Product Area of Sale"; "Applicant Product Area of Sale")
            {
                Caption = 'Areas of sale';
                SubPageLink = "Applicant No" = field("Application no"), Outlet = field(Outlet);
            }
            part("Sell to Whom"; "Applicant Sell to Whom")
            {
                Caption = 'Sell to whom';
                SubPageLink = "Applicant No" = field("Application no"), Outlet = field(Outlet);
            }
        }
    }
}
