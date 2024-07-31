page 50524 "Employee Card Custom"
{
    Caption = 'Employee Card';
    PromotedActionCategories = 'New,Process,Report,Change request';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Employee;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field(Gender; Rec.Gender)
                {
                }
                field(Disabled; Rec.Disabled)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled::No then begin
                            DisabilityView := false;
                        end
                        else
                            DisabilityView := true;
                    end;
                }
                group(Control197)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                    }
                }
                field("Date of Birth"; Rec."Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Date of Birth - Age"; Rec."Date of Birth - Age")
                {
                    Caption = ' Age';
                    Importance = Standard;
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field(Religion; Rec.Religion)
                {
                    Visible = false;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Caption = 'Ethnic Group';
                }
                field("Ethnic Community"; Rec."Ethnic Community")
                {
                    Caption = 'Ethnic Code';
                    Visible = false;
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    Caption = 'Ethnic Community';
                }
                field("Home District"; Rec."Home District")
                {
                }
                field("First Language"; Rec."First Language")
                {
                    Visible = false;
                }
                field("Second Language"; Rec."Second Language")
                {
                    Visible = false;
                }
                field("Other Language"; Rec."Other Language")
                {
                    Visible = false;
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';

                group(Control13)
                {
                    ShowCaption = false;

                    field(Address; Rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;

                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap;
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;

                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; Rec.Pager)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                    }
                    field(Extension; Rec.Extension)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = ' Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; Rec."Alt. Address Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field("Alt. Address End Date"; Rec."Alt. Address End Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';

                field("Job Position"; Rec."Job Position")
                {
                    Caption = 'Job ID';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Title2"; Rec."Job Title2")
                {
                    Caption = 'Title';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    Caption = 'Position';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = false;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                    }
                    field("Division/Section"; Rec."Division/Section")
                    {
                        ToolTip = 'Specifies the value of the Division/Section field.';
                        ApplicationArea = All;
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                    }
                }
            }
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Editable = false;

                field("Acting No"; Rec."Acting No")
                {
                }
                field(Control58; Rec."Acting Position")
                {
                }
                field("Acting Description"; Rec."Acting Description")
                {
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Debtor Code"; Rec."Debtor Code")
                {
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                    Visible = false;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                    Visible = false;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ShowMandatory = true;
                }
                field("NHIF No."; Rec."NHIF No")
                {
                    Caption = 'NHIF No.';
                }
                field("NSSF No."; Rec."Social Security No.")
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                }
                field("Employee's Bank"; Rec."Employee's Bank")
                {
                    Caption = 'Bank';
                    TableRelation = Banks;

                    trigger OnValidate()
                    begin
                        if Banks.Get(Rec."Employee's Bank") then BankName := Banks.Name;
                    end;
                }
                field("Employee Bank Name"; Rec."Employee Bank Name")
                {
                    Caption = 'Bank Name';
                    Editable = false;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    Caption = 'Branch';
                }
                field("Employee Branch Name"; Rec."Employee Branch Name")
                {
                    Caption = 'Branch Name';
                    Editable = false;
                }
                field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
                {
                    Caption = 'Sort Code';
                    Editable = false;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                }
                field(Present; Rec.Present)
                {
                    Caption = 'Present Pointer';
                }
                field(Previous; Rec.Previous)
                {
                    Caption = 'Previous Pointer';
                    Editable = false;
                }
                field(Halt; Rec.Halt)
                {
                    Caption = 'Halt Pointer';
                    Editable = false;
                }
                field("Incremental Month"; Rec."Incremental Month")
                {
                }
                field("Pays tax?"; Rec."Pays tax?")
                {
                }
                field("Secondary Employee"; Rec."Secondary Employee")
                {
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                }
                field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
                {
                    Visible = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("House Allowance"; Rec."House Allowance")
                {
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    Editable = false;
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                }
                field("Cumm. PAYE"; Rec."Cumm. PAYE")
                {
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Join"; Rec."Date Of Join")
                {
                    trigger OnValidate()
                    begin
                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                group(Estatus)
                {
                    ShowCaption = false;
                    Editable = Statuseditable;

                    field("Employment Status"; Rec."Employment Status")
                    {
                        Caption = 'Employment Status';

                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            StatusView;
                            CurrPage.Update();
                        end;
                    }
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the employment status of the employee.';
                    ApplicationArea = All;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                Visible = false;

                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                }
                field("Compassionate Leave Days"; Rec."Compassionate Leave Days")
                {
                }
                field("Maternity Leave Days"; Rec."Maternity Leave Days")
                {
                    Visible = Visibility;
                }
                field("Paternity Leave Days"; Rec."Paternity Leave Days")
                {
                    Visible = Visibility;
                }
                field("Sick Leave Days"; Rec."Sick Leave Days")
                {
                }
                field("Study Leave Days"; Rec."Study Leave Days")
                {
                }
                field("Other Leave Days (Total)"; Rec."Other Leave Days (Total)")
                {
                }
            }
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Visible = false;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Picture)
            {
                Caption = 'Picture';
                Image = Picture;

                action("Co&mments")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                    Visible = true;
                }
                action(Dimensions)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    Visible = true;
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                    Visible = true;
                }
            }
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;

                action(Action81)
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Action184)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(Action76)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Action23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.") ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No."), "Remaining Amount" = FILTER(< 0), "Applies-to ID" = FILTER('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                }
                action("Next of Kin")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageMode = View;
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action(Action189)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action(Action188)
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action(Action187)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action(Action186)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                action(Disciplinary)
                {
                    Image = DeleteAllBreakpoints;
                    RunObject = Page "Closed Disciplinary Cases";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
                separator(Action182)
                {
                }
                action(Action181)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action(Action180)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action(Action179)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action178)
                {
                }
                action(Action177)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.") ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Employment History")
                {
                    Image = History;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Employment History ";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Employee Appointment Checklist")
                {
                    Caption = 'Appointment Checklist';
                    Image = CheckList;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Appointment Checklist ListPart";
                }
                action("Leave Aplications")
                {
                    Image = JobResponsibility;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    //The property 'PromotedOnly' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedOnly = true;
                    RunObject = Page "Leave Application List";
                    RunPageLink = "Employee No" = FIELD("No.");
                }
                action("Professional Membership")
                {
                    Image = Agreement;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Professional Membership";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Union)
                {
                    Image = Union;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                }
                action(House)
                {
                    Image = Warehouse;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Houses List";
                    RunPageLink = "Allocated Employee" = FIELD("No.");
                }
                action("Acting Positions")
                {
                    Image = EditCustomer;
                    RunObject = Page "Acting Duties List";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Beneficiaries)
                {
                    Image = Employee;
                    RunObject = Page "Employee Beneficiaries";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Visible = false;

                group(Action192)
                {
                    Caption = 'Performance Management';
                    Image = Travel;

                    action(Appraisal)
                    {
                        trigger OnAction()
                        begin
                            Message('Coming Soon');
                        end;
                    }
                }
            }
        }
        area(creation)
        {
            group(Earnings)
            {
            }
            action("Assign Earnings")
            {
                Caption = 'Assign Earnings';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(false);
            }
            action(List)
            {
                RunObject = Page Earnings;
            }
            action("Dispay Reccuring Earnings")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST(Recurring), Closed = CONST(false);
            }
            action("Display Non-reccuring Earnings")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Frequency = CONST("Non-recurring"), Closed = CONST(false);
            }
            group(Deductions)
            {
            }
            action("Assign Deductions")
            {
                Caption = 'Assign Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(false);
            }
            action("Deductions List")
            {
                RunObject = Page Deductions;
            }
            action("Display Reccuring Deductions")
            {
                Caption = 'Display Reccuring Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST(Recurring), Closed = CONST(false);
            }
            action("Display Non-reccuring Deductions")
            {
                Caption = 'Display Non-reccuring Deductions';
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Frequency = CONST("Non-recurring"), Closed = CONST(false);
            }
            action("Opening Balances")
            {
                RunObject = Page "Deductions Balances";
                RunPageLink = "Employee No" = FIELD("No.");
            }
            group(Loans)
            {
            }
            action("Deduction Loan")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Loan), Closed = CONST(false);
            }
            action("Employee Loan(s) List")
            {
                Caption = 'Employee Loan(s) List';
            }
            action("Savings Withdrawals")
            {
                RunObject = Page "Payments & Deductions";
                RunPageLink = "Employee No" = FIELD("No."), Closed = CONST(false), Type = CONST("Saving Scheme");
            }
            group("Pay Manager")
            {
            }
            action("Pay Information")
            {
            }
            separator(Action151)
            {
            }
            action("Account Mapping")
            {
            }
        }
        area(processing)
        {
            action("Assign Default Ded/Earnings")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.DefaultAssignment();
                end;
            }
            action(Payslip)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then CurrentMonth := PayPeriod."Starting Date";
                    Employee.SetRange("No.", Rec."No.");
                    Employee.SetRange("Pay Period Filter", CurrentMonth);
                    REPORT.Run(Report::"New Payslipx", true, false, Employee);
                end;
            }
            action("Payroll Run")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then begin
                        CurrentMonth := PayPeriod."Starting Date";
                        Employee.SetRange("Pay Period Filter", CurrentMonth);
                        REPORT.Run(Report::"Payroll Run1", true, false, Employee);
                    end
                    else
                        Error('You cannot run payroll for a closed period')
                end;
            }
            action("Yearly Bonus")
            {
                Image = Holiday;

                trigger OnAction()
                begin
                    Payroll.GetYearlyBonus(Rec."No.");
                end;
            }
            action("Mail Payslip")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MailBulkPayslips: Report "Mail Bulk Payslips";
                begin
                    if Confirm(Text0001, false) = true then begin
                        //Mail single
                        Employee.Reset;
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst then begin
                            MailBulkPayslips.SetTableView(Employee);
                            MailBulkPayslips.Run;
                        end;
                    end
                    else
                        exit;
                end;
            }
            action("Mail P9")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MailBulkP9s: Report "Mail Bulk P9s";
                begin
                    if Confirm(Text0001, false) = true then begin
                        //Mail single
                        Employee.Reset;
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst then begin
                            MailBulkP9s.SetTableView(Employee);
                            MailBulkP9s.Run;
                        end;
                    end
                    else
                        exit;
                end;
            }
            action("Import Data")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Clear(EmployeeXML);
                    EmployeeXML.Run;
                end;
            }
            action("Change Request")
            {
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Numb := HRMgt.EmployeeChangeReq(Rec);
                    EmployeeChange.SetRange(Number, Numb);
                    HRMgt.EmployeeChangeReq(Rec);
                    PAGE.Run(Page::"Employee Change Card", EmployeeChange);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnOpenPage()
    begin
        StatusView;
        SetNoFieldVisible;
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
        SetContractView();
        DisabilityView := false;
        //ProbationPeriod:=HRSetup."Probation Duration";
        if LeaveType.Get('ANNUAL') then Rec."Annual Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('PATERNITY') then begin
            if Rec.Gender = LeaveType.Gender then Visibility := true;
            Rec."Paternity Leave Days" := LeaveType.Days;
        end
        else
            Visibility := false;
        //MODIFY;
        if LeaveType.Get('COMPASSION') then Rec."Compassionate Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('SICK') then Rec."Sick Leave Days" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('UNPAID') then Rec."Other Leave Days (Total)" := LeaveType.Days;
        //MODIFY;
        if LeaveType.Get('MATERNITY') then begin
            if Rec.Gender = LeaveType.Gender then
                Visibility := true
            else
                Visibility := false;
            Rec."Maternity Leave Days" := LeaveType.Days;
        end
        else
            Visibility := false;
        //MODIFY;
        if LeaveType.Get('STUDY') then Rec."Study Leave Days" := LeaveType.Days;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        StatusView;
    end;

    var
        ShowMapLbl: Label 'Show on Map';
        FormatAddress: Codeunit "Format Address";
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
        ContractView: Boolean;
        BankName: Text;
        Statuseditable: Boolean;
        Banks: Record Banks;
        ProbationPeriod: DateFormula;
        HRSetup: Record "Human Resources Setup";
        LeaveType: Record "Leave Type";
        Visibility: Boolean;
        DisabilityView: Boolean;
        PayPeriod: Record "Payroll PeriodX";
        CurrentMonth: Date;
        Employee: Record Employee;
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        HRMgt: Codeunit "HR Management";
        Numb: Code[20];
        EmployeeChange: Record "Employee Change Request";
        Text0001: Label 'Do you want to send the payslip?';

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible;
    end;

    local procedure SetContractView()
    begin
        if Rec."No." <> '' then begin
            if Rec."Nature of Employment" <> 'CONTRACT' then begin
                ContractView := false;
            end
            else
                ContractView := true;
        end;
    end;

    procedure StatusView()
    begin
        if Rec."Employment Status" <> Rec."Employment Status"::"Permanently Inactive" then
            Statuseditable := true
        else
            Statuseditable := false;
    end;

    local procedure ContractFields()
    begin
        /*//"Contract Type":='';
            "Contract Number":=0;
            "Contract Start Date":=0D;
            "Contract End Date":=0D;
            "Send Alert to":='';
            MODIFY;
            */
    end;

    local procedure Disability()
    begin
        if Rec."No." <> '' then begin
            if Rec.Disabled = Rec.Disabled::No then begin
                DisabilityView := false;
            end
            else
                DisabilityView := true;
        end;
    end;

    local procedure DisabilityField()
    begin
        Rec.Disability := '';
    end;

    local procedure GetCurrentPayPeriod(): Date
    var
        PayrollPeriod: Record "Payroll PeriodX";
    begin
        PayPeriod.Reset;
        PayPeriod.SetRange(Closed, false);
        if PayPeriod.FindFirst then exit(PayPeriod."Starting Date");
    end;
}
