report 50521 Employees
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Employee List.rdl';
    Caption = 'Employees';
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(ActingDescription; "Acting Description")
            {
            }
            column(ActingNo; "Acting No")
            {
            }
            column(ActingPosition; "Acting Position")
            {
            }
            column(ActivationCode; "Activation Code")
            {
            }
            column(AdditionalLanguage; "Additional Language")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(AllowReEmploymentInFuture; "Allow Re-Employment In Future")
            {
            }
            column(AltAddressCode; "Alt. Address Code")
            {
            }
            column(AltAddressEndDate; "Alt. Address End Date")
            {
            }
            column(AltAddressStartDate; "Alt. Address Start Date")
            {
            }
            column(AlternativeBranchCode; "Alternative Branch Code")
            {
            }
            column(AnnualLeaveDays; "Annual Leave Days")
            {
            }
            column(ApplicationMethod; "Application Method")
            {
            }

            column(Balance; Balance)
            {
            }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankAccountNumber; "Bank Account Number")
            {
            }
            column(BankBranch; "Bank Branch")
            {
            }
            column(BankBranchNo; "Bank Branch No.")
            {
            }
            column(BasicArrears; "Basic Arrears")
            {
            }
            column(BasicPay; "Basic Pay")
            {
            }
            column(BenefitsNonCash; "Benefits-Non Cash")
            {
            }
            column(BirthDate; "Birth Date")
            {
            }
            column(BloodType; "Blood Type")
            {
            }
            column(CashLeaveEarned; "Cash - Leave Earned")
            {
            }
            column(CashPerLeaveDay; "Cash Per Leave Day")
            {
            }
            column(CauseofInactivityCode; "Cause of Inactivity Code")
            {
            }
            column(City; City)
            {
            }
            column(CoOperativeNo; "Co-Operative No")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CommuterAllowance; "Commuter Allowance")
            {
            }
            column(Company; Company)
            {
            }
            column(CompanyEMail3; "Company E-Mail")
            {
            }
            column(CompassionateLeaveDays; "Compassionate Leave Days")
            {
            }
            column(ContractEndDate; "Contract End Date")
            {
            }
            column(ContractLength; "Contract Length")
            {
            }
            column(ContractNumber; "Contract Number")
            {
            }
            column(ContractStartDate; "Contract Start Date")
            {
            }
            column(ContractType; "Contract Type")
            {
            }
            column(CostCenterCode; "Cost Center Code")
            {
            }
            column(CostObjectCode; "Cost Object Code")
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(County; County)
            {
            }
            column(CountyCode; "County Code")
            {
            }
            column(CountyName; "County Name")
            {
            }
            column(CummPAYE; "Cumm. PAYE")
            {
            }
            column(CummSecondaryPAYE; "Cumm. Secondary  PAYE")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyCodes; "Currency Codes")
            {
            }
            column(CurrentDate; "Current Date")
            {
            }
            column(CurrentLeavePeriod; "Current Leave Period")
            {
            }
            column(DateOfJoin; "Date Of Join")
            {
            }
            column(DateOfLeaving; "Date Of Leaving")
            {
            }
            column(DateOfJoiningPayroll; "Date OfJoining Payroll")
            {
            }
            column(DateofBirthAge; "Date of Birth - Age")
            {
            }
            column(DebtorCode; "Debtor Code")
            {
            }
            column(Directorate; Directorate)
            {
            }
            column(Disability; Disability)
            {
            }
            column(DisabilityCertificate; "Disability Certificate")
            {
            }
            column(Disabled; Disabled)
            {
            }
            column(DivisionSection; "Division/Section")
            {
            }
            column(DrivingLicence; "Driving Licence")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(EmployeeActQty; "Employee Act. Qty")
            {
            }
            column(EmployeeArcQty; "Employee Arc. Qty")
            {
            }
            column(EmployeeBankName; "Employee Bank Name")
            {
            }
            column(EmployeeBankSortCode; "Employee Bank Sort Code")
            {
            }
            column(EmployeeBranchName; "Employee Branch Name")
            {
            }
            column(EmployeeJobType; "Employee Job Type")
            {
            }
            column(EmployeeNature; "Employee Nature")
            {
            }
            column(EmployeePostingGroup; "Employee Posting Group")
            {
            }
            column(EmployeeQty; "Employee Qty")
            {
            }
            column(EmployeesBank; "Employee's Bank")
            {
            }
            column(EmploymentDate; "Employment Date")
            {
            }
            column(EmploymentDateAge; "Employment Date - Age")
            {
            }
            column(EmploymentStatus; "Employment Status")
            {
            }
            column(EmploymentType; "Employment Type")
            {
            }
            column(EmplymtContractCode; "Emplymt. Contract Code")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(EndOfProbationDate; "End Of Probation Date")
            {
            }
            column(EthnicCommunity; "Ethnic Community")
            {
            }
            column(EthnicName; "Ethnic Name")
            {
            }
            column(EthnicOrigin; "Ethnic Origin")
            {
            }
            column(ExitInterviewDate; "Exit Interview Date")
            {
            }
            column(ExitInterviewDoneby; "Exit Interview Done by")
            {
            }
            column(ExitRefNo; "Exit Ref No")
            {
            }
            column(Extension; Extension)
            {
            }
            column(FaxNo; "Fax No.")
            {
            }
            column(FirstLanguage; "First Language")
            {
            }
            column(FirstLanguageRWS; "First Language (R/W/S)")
            {
            }
            column(FirstLanguageRead; "First Language Read")
            {
            }
            column(FirstLanguageSpeak; "First Language Speak")
            {
            }
            column(FirstLanguageWrite; "First Language Write")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(FullPartTime; "Full / Part Time")
            {
            }
            column(Gender; Gender)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GratuityVendorNo; "Gratuity Vendor No.")
            {
            }
            column(GroundsforTermCode; "Grounds for Term. Code")
            {
            }
            column(HELBNo; "HELB No")
            {
            }
            column(Halt; Halt)
            {
            }
            column(HomeDistrict; "Home District")
            {
            }
            column(HomeSavings; "Home Savings")
            {
            }
            column(HoursWorked; "Hours Worked")
            {
            }
            column(HouseAllowance; "House Allowance")
            {
            }
            column(HudumaNumber; "Huduma Number")
            {
            }
            column(HumanResouceManager; "Human Resouce Manager")
            {
            }
            column(IBAN; IBAN)
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(Image; Image)
            {
            }
            column(ImprestCustomerCode; "Imprest Customer Code")
            {
            }
            column(InactiveDate; "Inactive Date")
            {
            }
            column(IncrementalMonth; "Incremental Month")
            {
            }
            column(Initials; Initials)
            {
            }
            column(InsurancePremium; "Insurance Premium")
            {
            }
            column(InsuranceRelief; "Insurance Relief")
            {
            }
            column(Interest; Interest)
            {
            }
            column(IsLecturer; "Is Lecturer")
            {
            }
            column(JobPosition; "Job Position")
            {
            }
            column(JobPositionTitle; "Job Position Title")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(JobTitle2; "Job Title2")
            {
            }
            column(KRAPINNo; "KRA PIN No.")
            {
            }
            column(LastDateModified; "Last Date Modified")
            {
            }
            column(LastModifiedDateTime; "Last Modified Date Time")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(LeaveBalance; "Leave Balance")
            {
            }
            column(LeaveCategory; "Leave Category")
            {
            }
            column(LeavePeriodFilter; "Leave Period Filter")
            {
            }
            column(LeaveTypeFilter; "Leave Type Filter")
            {
            }
            column(LecturerPassword; "Lecturer Password")
            {
            }
            column(LecturerType; "Lecturer Type")
            {
            }
            column(LoanInterest; "Loan Interest")
            {
            }
            column(LostBook; "Lost Book")
            {
            }
            column(Manager; Manager)
            {
            }
            column(ManagerNo; "Manager No.")
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(MaternityLeaveDays; "Maternity Leave Days")
            {
            }
            column(MedicalMemberNo; "Medical Member No")
            {
            }
            column(MedicalSchemeJoin; "Medical Scheme Join")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(MinTaxRate; "Min Tax Rate")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(NHIFNo; "NHIF No")
            {
            }
            column(NSSFNo; "NSSF No.")
            {
            }
            column(Name; Name)
            {
            }
            column(NatureofEmployment; "Nature of Employment")
            {
            }
            column(NetPay; "Net Pay")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NoofMembers; "No. of Members")
            {
            }
            column(NoticePeriod; "Notice Period")
            {
            }
            column(OtherLanguage; "Other Language")
            {
            }
            column(OtherLanguageRead; "Other Language Read")
            {
            }
            column(OtherLanguageSpeak; "Other Language Speak")
            {
            }
            column(OtherLanguageWrite; "Other Language Write")
            {
            }
            column(OtherLeaveDaysTotal; "Other Leave Days (Total)")
            {
            }
            column(Otherdeductions; "Other deductions")
            {
            }
            column(OwnerOccupier; "Owner Occupier")
            {
            }
            column(PINNumber; "PIN Number")
            {
            }
            column(Pager; Pager)
            {
            }
            column(PassportNumber; "Passport Number")
            {
            }
            column(Password; Password)
            {
            }
            column(PaternityLeaveDays; "Paternity Leave Days")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(PayrollReactivationDate; "Payroll Reactivation Date")
            {
            }
            column(PayrollSuspenstionDate; "Payroll Suspenstion Date")
            {
            }
            column(PaysNSSF; "Pays NSSF?")
            {
            }
            column(Paystax; "Pays tax?")
            {
            }
            column(PensionContribution; "Pension Contribution")
            {
            }
            column(PensionContributionBenefit; "Pension Contribution Benefit")
            {
            }
            column(PensionSchemeJoin; "Pension Scheme Join")
            {
            }
            column(PensionNo; PensionNo)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(PortalRegistered; "Portal Registered")
            {
            }
            column(Position; Position)
            {
            }
            column(PositionTOSucceed; "Position TO Succeed")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PostingGroup; "Posting Group")
            {
            }
            column(Present; Present)
            {
            }
            column(Previous; Previous)
            {
            }
            column(PrivacyBlocked; "Privacy Blocked")
            {
            }
            column(ProRataCalculated; "Pro-Rata Calculated")
            {
            }
            column(Race; Race)
            {
            }
            column(ReasonforActing; "Reason for Acting")
            {
            }
            column(ReimbursedLeaveDays; "Reimbursed Leave Days")
            {
            }
            column(ReliefAmount; "Relief Amount")
            {
            }
            column(RelievedEmployee; "Relieved Employee")
            {
            }
            column(RelievedName; "Relieved Name")
            {
            }
            column(Religion; Religion)
            {
            }
            column(ResourceCentre; "Resource Centre")
            {
            }
            column(ResourceNo; "Resource No.")
            {
            }
            column(ResourceRequestStatus; "Resource Request Status")
            {
            }
            column(RetirementContribution; "Retirement Contribution")
            {
            }
            column(RetirementDate; "Retirement Date")
            {
            }
            column(SSFEmployertoDate; "SSF Employer to Date")
            {
            }
            column(SWIFTCode; "SWIFT Code")
            {
            }
            column(SalaryArrears; "Salary Arrears")
            {
            }
            column(SalaryScale; "Salary Scale")
            {
            }
            column(SalespersPurchCode; "Salespers./Purch. Code")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(SecondLanguage; "Second Language")
            {
            }
            column(SecondLanguageRWS; "Second Language (R/W/S)")
            {
            }
            column(SecondLanguageRead; "Second Language Read")
            {
            }
            column(SecondLanguageSpeak; "Second Language Speak")
            {
            }
            column(SecondLanguageWrite; "Second Language Write")
            {
            }
            column(SecondaryEmployee; "Secondary Employee")
            {
            }
            column(SendAlertto; "Send Alert to")
            {
            }
            column(ServedNoticePeriod; "Served Notice Period")
            {
            }
            column(ShareAmount; "Share Amount")
            {
            }
            column(SickLeaveDays; "Sick Leave Days")
            {
            }
            column(Signature; Signature)
            {
            }
            column(SocialSecurityNo; "Social Security No.")
            {
            }
            column(SpecialRetirementAge; "Special Retirement Age")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(StatisticsGroupCode; "Statistics Group Code")
            {
            }
            column(Status; Status)
            {
            }
            column(StudyLeaveDays; "Study Leave Days")
            {
            }
            column(SuccesionDate; "Succesion Date")
            {
            }
            column(TaxDeductibleAmount; "Tax Deductible Amount")
            {
            }
            column(TaxableAllowance; "Taxable Allowance")
            {
            }
            column(TaxableIncome; "Taxable Income")
            {
            }
            column(TerminationCategory; "Termination Category")
            {
            }
            column(TerminationDate; "Termination Date")
            {
            }
            column(Title; Title)
            {
            }
            column(TotalAbsenceBase; "Total Absence (Base)")
            {
            }
            column(TotalAllowances; "Total Allowances")
            {
            }
            column(TotalDeductions; "Total Deductions")
            {
            }
            column(TotalLeaveBalance; "Total Leave Balance")
            {
            }
            column(TotalSavings; "Total Savings")
            {
            }
            column(TypeofContract; "Type of Contract")
            {
            }
            column(UnionCode; "Union Code")
            {
            }
            column(UnionMembershipNo; "Union Membership No.")
            {
            }
            column(UserID; "User ID")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    END;

    VAR
        CompanyInfo: Record "Company Information";
}
